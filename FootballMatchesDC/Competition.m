//
//  Competition.m
//  FootballMatchesDC
//
//  Created by Developer on 22/09/18.
//  Copyright © 2018 Developer. All rights reserved.
//

#import "Competition.h"
#import "MatchesViewController.h"

@implementation Competition

- (instancetype)initWithCompetitionID:(NSNumber *)competitionID andCompetitionName:(NSString *)competitionName
{
    self = [super init];
    if (self) {
            self.competitionId = competitionID;
            self.competitionName = competitionName;
    }
    return self;
}

- (NSString *)description {
    NSString *descriptionString = [NSString stringWithFormat:@"Competition number %@ and name %@ ", self.competitionId, self.competitionName];
    return descriptionString;
    
}
@end
