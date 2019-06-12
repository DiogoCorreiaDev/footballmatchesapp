//
//  Competition.h
//  FootballMatchesDC
//
//  Created by Developer on 22/09/18.
//  Copyright © 2018 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Competition : NSObject

@property (strong, nonatomic) NSString *competitionName;
@property (strong, nonatomic) NSNumber *competitionId;


- (instancetype)initWithCompetitionID:(NSNumber *)competitionID andCompetitionName:(NSString *)competitionName;

- (NSString *)description;

@end
