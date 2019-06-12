//
//  MatchesClientAPI.m
//  FootballMatchesDC
//
//  Created by Developer on 22/09/18.
//  Copyright © 2018 Developer. All rights reserved.
//

#import "MatchesClientAPI.h"
#import "MatchesViewController.h"
#import "DateString.h"
#import "LeaguePosition.h"

@implementation MatchesClientAPI

- (void)getAllMatches:(void (^)(NSArray <Match *> *, NSError *))completion
{
    NSURL *url = [NSURL URLWithString:@"http://api.football-data.org/v2/matches"];
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue:@"4a8c4420bc124304b0367263b79a075a" forHTTPHeaderField:@"X-Auth-Token"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            completion(nil, error);
        } else {
            NSError *jsonError;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers
                                                                                 error:&jsonError];
            if (jsonError) {
                completion(nil, jsonError);
            } else {
                NSArray *matchesDictionaries = responseDictionary[@"matches"];
                NSMutableArray *matches = [NSMutableArray array];
                //NSMutableArray *allCompetitionsId = [NSMutableArray array];
                
                for (NSDictionary *matchDictionary in matchesDictionaries) {
                    Match *match = [[Match alloc] initWithDictionary:matchDictionary];
                    [matches addObject:match];
                }
                completion([matches copy], nil);
            }
        }
    }];
    
    [task resume];
}

- (void)getAllMatchesForTomorrow:(void (^)(NSArray <Match *> *, NSError *))completion
{

    NSString *urlFirst = @"http://api.football-data.org/v2/matches?dateFrom=";
    DateString *date = [[DateString alloc] init];
    NSString *urlDate = [date getDateFromTodayPlusOrMinus:-1];
    //NSString *urlDate = [date getTomorrow];
    NSLog(@"DATA %@",urlDate);
    NSString *urlSecond = @"&dateTo=";
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@%@", urlFirst, urlDate, urlSecond, urlDate];
    NSLog(@"API STRING %@",urlString);
    

    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue:@"4a8c4420bc124304b0367263b79a075a" forHTTPHeaderField:@"X-Auth-Token"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            completion(nil, error);
        } else {
            NSError *jsonError;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers
                                                                                 error:&jsonError];
            if (jsonError) {
                completion(nil, jsonError);
            } else {
                NSArray *matchesDictionaries = responseDictionary[@"matches"];
                NSMutableArray *matches = [NSMutableArray array];
                //NSMutableArray *allCompetitionsId = [NSMutableArray array];
                
                for (NSDictionary *matchDictionary in matchesDictionaries) {
                    Match *match = [[Match alloc] initWithDictionary:matchDictionary];
                    [matches addObject:match];
                }
                completion([matches copy], nil);
            }
        }
    }];
    
    [task resume];
}

- (void)getAllMatchesFor:(NSInteger)day :(void (^)(NSArray <Match *> *, NSError *))completion
{
    NSString *urlFirst = @"http://api.football-data.org/v2/matches?dateFrom=";
    DateString *date = [[DateString alloc] init];
    NSString *urlDate = [date getDateFromTodayPlusOrMinus:day];
    NSLog(@"DATA METODO TESTE %@",urlDate);
    NSString *urlSecond = @"&dateTo=";
    //NSString *urlString = @"http://api.football-data.org/v2/matches?dateFrom=2018-09-23&dateTo=2018-09-23";
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@%@", urlFirst, urlDate, urlSecond, urlDate];
    //NSLog(@"API STRING %@",urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue:@"4a8c4420bc124304b0367263b79a075a" forHTTPHeaderField:@"X-Auth-Token"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            completion(nil, error);
        } else {
            NSError *jsonError;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers
                                                                                 error:&jsonError];
            if (jsonError) {
                completion(nil, jsonError);
            } else {
                NSArray *matchesDictionaries = responseDictionary[@"matches"];
                NSMutableArray *matches = [NSMutableArray array];
                //NSMutableArray *allCompetitionsId = [NSMutableArray array];
                
                for (NSDictionary *matchDictionary in matchesDictionaries) {
                    Match *match = [[Match alloc] initWithDictionary:matchDictionary];
                    [matches addObject:match];
                }
                completion([matches copy], nil);
            }
        }
    }];
    
    [task resume];
}

- (void)getStandingsFor:(Competition *)competition :(void (^)(NSArray <LeaguePosition *> *, NSError *))completion
{
    NSString *urlFirst = @"http://api.football-data.org/v2/competitions/";
    NSString *urlSecond = @"/standings";
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@", urlFirst, competition.competitionId, urlSecond];
    NSLog(@"STANDINGS URL STRING %@",urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue:@"4a8c4420bc124304b0367263b79a075a" forHTTPHeaderField:@"X-Auth-Token"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            completion(nil, error);
        } else {
            NSError *jsonError;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers
                                                                                 error:&jsonError];
            if (jsonError) {
                completion(nil, jsonError);
            } else {
                NSArray *standingsDictionaries = responseDictionary[@"standings"][0][@"table"];
                NSMutableArray *standings = [NSMutableArray array];
                
                for (NSDictionary *leaguePositionDictionary in standingsDictionaries) {
                    LeaguePosition *leaguePosition = [[LeaguePosition alloc] initWithDictionary:leaguePositionDictionary andCompetition:competition];
                    [standings addObject:leaguePosition];
                }
                completion([standings copy], nil);
            }
        }
    }];
    
    [task resume];
}
@end
