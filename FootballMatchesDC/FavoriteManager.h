//
//  FavoriteManager.h
//  FootballMatchesDC
//
//  Created by Developer on 29/09/18.
//  Copyright © 2018 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FavoriteTeamMO+CoreDataProperties.h"

@interface FavoriteManager : NSObject

+ (void)createFavoriteTeamWithName:(NSString *)name andId:(NSNumber *)idNumber;

+ (void)createFavoriteTeamWithName:(NSString *)name;

+ (BOOL)isTeamFavoriteWithTeamName:(NSString *)teamName;

+ (NSArray <FavoriteTeamMO *> *)allFavoriteTeams;

@end
