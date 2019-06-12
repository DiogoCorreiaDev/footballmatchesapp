//
//  Match.m
//  FootballMatchesDC
//
//  Created by Developer on 22/09/18.
//  Copyright © 2018 Developer. All rights reserved.
//

#import "Match.h"
#import "MatchesViewController.h"

@implementation Match

- (instancetype)initWithCompetition:(Competition *)competition
                    andHomeTeamName:(NSString *)homeTeamName
                   andHomeTeamScore:(NSNumber *)homeTeamScore
                    andAwayTeamName:(NSString *)awayTeamName
                   andAwayTeamScore:(NSNumber *)awayTeamScore
                            andDate:(NSString *)date
                          andStatus:(NSString *)status
{
    self = [super init];
    if (self) {
        self.competition = competition;
        self.homeTeamName = homeTeamName;
        self.homeTeamScore = homeTeamScore;
        self.awayTeamName = awayTeamName;
        self.awayTeamScore = awayTeamScore;
        self.date = date;
        self.status = status;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)matchDictionary
{
    self = [super init];
    if (self) {
        self.status = matchDictionary[@"status"];
        self.date = [self getTimeFrom:matchDictionary[@"utcDate"]];
        //self.date = matchDictionary[@"utcDate"];
        
        self.awayTeamName = matchDictionary[@"awayTeam"][@"name"];
        self.awayTeamScore = matchDictionary[@"score"][@"fullTime"][@"awayTeam"];
        self.homeTeamName = matchDictionary[@"homeTeam"][@"name"];
        self.homeTeamScore = matchDictionary[@"score"][@"fullTime"][@"homeTeam"];

        Competition *competition = [[Competition alloc] initWithCompetitionID:matchDictionary[@"competition"][@"id"] andCompetitionName:matchDictionary[@"competition"][@"name"]];
        self.competition = competition;
    }
    return self;
}

-(NSString *)getTimeFrom:(NSString *)date{
    NSArray *dateSeparatedByColon = [date componentsSeparatedByString:@":"];
    NSString *dateUntilMinutes = [dateSeparatedByColon objectAtIndex:0];
    NSString *hour= [dateUntilMinutes substringFromIndex:[dateUntilMinutes length]-2];
    NSString *minutes = [dateSeparatedByColon objectAtIndex:1];
    NSString *time = [NSString stringWithFormat:@"%@h%@", hour, minutes];
    return time;
}

- (NSComparisonResult)compareMatchCompetition:(Match *)otherMatch {
    return [self.competition.competitionId compare:otherMatch.competition.competitionId];
}

- (NSString *)description {
    NSString *descriptionString = [NSString stringWithFormat:@"Match com Cp id= %@, Cpnome = %@", self.competition.competitionId, self.competition.competitionName];
    return descriptionString;
    
}
@end
