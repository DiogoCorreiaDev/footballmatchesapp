//
//  LeaguePosition.h
//  FootballMatchesDC
//
//  Created by user146165 on 9/25/18.
//  Copyright © 2018 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Competition.h"

NS_ASSUME_NONNULL_BEGIN

@interface LeaguePosition : NSObject

@property (strong, nonatomic) Competition *competition;
@property (strong, nonatomic) NSNumber *position;
@property (strong, nonatomic) NSString *teamName;
@property (strong, nonatomic) NSNumber *playedGames;
@property (strong, nonatomic) NSNumber *points;

- (instancetype)initWithDictionary:(NSDictionary *)leaguePositionDictionary andCompetition:(Competition *)competition;

- (NSComparisonResult)compareLeaguePosition:(LeaguePosition *)otherLeaguePosition;

- (NSString *)description;

@end

NS_ASSUME_NONNULL_END
