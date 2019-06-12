//
//  Match.h
//  FootballMatchesDC
//
//  Created by Developer on 22/09/18.
//  Copyright © 2018 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Competition.h"

@interface Match : NSObject

@property (strong, nonatomic) Competition *competition;
@property (strong, nonatomic) NSString *homeTeamName;
@property (strong, nonatomic) NSString *awayTeamName;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSNumber *homeTeamScore;
@property (strong, nonatomic) NSNumber *awayTeamScore;

- (instancetype)initWithCompetition:(Competition *)competition
                    andHomeTeamName:(NSString *)homeTeamName
                   andHomeTeamScore:(NSNumber *)homeTeamScore
                    andAwayTeamName:(NSString *)awayTeamName
                   andAwayTeamScore:(NSNumber *)awayTeamScore
                            andDate:(NSString *)date
                          andStatus:(NSString *)status;

- (instancetype)initWithDictionary:(NSDictionary *)matchDictionary;

- (NSComparisonResult)compareMatchCompetition:(Match *)otherMatch;

@end
