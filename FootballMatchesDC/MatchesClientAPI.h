//
//  MatchesClientAPI.h
//  FootballMatchesDC
//
//  Created by Developer on 22/09/18.
//  Copyright © 2018 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Match.h"
#import "LeaguePosition.h"

@interface MatchesClientAPI : NSObject

@property (strong, nonatomic) NSMutableArray <NSNumber *> *allCompetitionsId;

- (void)getAllMatchesFor:(NSInteger)day :(void (^)(NSArray <Match *> *, NSError *))completion;

- (void)getAllMatches:(void (^)(NSArray <Match *> *, NSError *))completion;

- (void)getStandingsFor:(Competition *)competition :(void (^)(NSArray <LeaguePosition *> *, NSError *))completion;

- (void)getAllMatchesForTomorrow:(void (^)(NSArray <Match *> *, NSError *))completion;

@end
