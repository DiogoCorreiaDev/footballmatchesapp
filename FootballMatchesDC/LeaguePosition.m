//
//  LeaguePosition.m
//  FootballMatchesDC
//
//  Created by user146165 on 9/25/18.
//  Copyright © 2018 Developer. All rights reserved.
//

#import "LeaguePosition.h"

@implementation LeaguePosition

- (instancetype)initWithDictionary:(NSDictionary *)leaguePositionDictionary andCompetition:(Competition *)competition
{
    self = [super init];
    if (self) {
        self.position = leaguePositionDictionary[@"position"];
        self.points = leaguePositionDictionary[@"points"];
        self.playedGames = leaguePositionDictionary[@"playedGames"];
        self.teamName = leaguePositionDictionary[@"team"][@"name"];
        self.competition = competition;
    }
    return self;
}

- (NSComparisonResult)compareLeaguePosition:(LeaguePosition *)otherLeaguePosition {
    return [self.position compare:otherLeaguePosition.position];
}

- (NSString *)description {
    NSString *descriptionString = [NSString stringWithFormat:@"League position number %@ and name %@ ", self.position, self.teamName];
    return descriptionString;
    
}
@end
