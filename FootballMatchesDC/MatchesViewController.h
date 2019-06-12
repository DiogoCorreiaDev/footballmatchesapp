//
//  MatchesViewController.h
//  FootballMatchesDC
//
//  Created by Developer on 22/09/18.
//  Copyright © 2018 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Competition.h"
#import "Match.h"

@interface MatchesViewController : UIViewController

@property (strong, nonatomic) NSMutableArray <Competition *> *allCompetitions;

-(void)getArrayOfCompetitions:(NSArray <Match *>* )matches;


@end
