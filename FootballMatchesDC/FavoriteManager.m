//
//  FavoriteManager.m
//  FootballMatchesDC
//
//  Created by Developer on 29/09/18.
//  Copyright © 2018 Developer. All rights reserved.
//

#import "FavoriteManager.h"
#import "AppDelegate.h"

@implementation FavoriteManager

+ (void)createFavoriteTeamWithName:(NSString *)name andId:(NSNumber *)idNumber
{
    NSManagedObjectContext *context = [FavoriteManager context];
    
    FavoriteTeamMO *favoriteTeam = [NSEntityDescription insertNewObjectForEntityForName:@"Team" inManagedObjectContext:context];
    favoriteTeam.idNumber = idNumber.intValue;
    favoriteTeam.name = name;
    
    [context save:nil];
}

+ (void)createFavoriteTeamWithName:(NSString *)name
{
    NSManagedObjectContext *context = [FavoriteManager context];
    
    FavoriteTeamMO *favoriteTeam = [NSEntityDescription insertNewObjectForEntityForName:@"Team" inManagedObjectContext:context];
    favoriteTeam.name = name;
    
    [context save:nil];
}

+ (NSManagedObjectContext *)context
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return appDelegate.persistentContainer.viewContext;
}

+ (NSArray <FavoriteTeamMO *> *)allFavoriteTeams
{
     NSManagedObjectContext *context = [FavoriteManager context];
     NSFetchRequest *favoritesFetch = [FavoriteTeamMO fetchRequest];
     NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
     favoritesFetch.sortDescriptors = @[sort];
     NSArray <FavoriteTeamMO *> *allFavoriteTeams = [context executeFetchRequest:favoritesFetch error:nil];
     return allFavoriteTeams;
}

+ (BOOL)isTeamFavoriteWithTeamName:(NSString *)teamName {
    NSArray <FavoriteTeamMO *> *allFavoriteTeams = [self allFavoriteTeams];
    int counter = 0;
    for (int i=0; i<allFavoriteTeams.count; i++) {
        if ([teamName isEqualToString:[allFavoriteTeams objectAtIndex:i].name]) {
            counter++;
        }
    }
    if (counter==0) {
        return NO;
    } else {
        return YES;
    }
}


@end
