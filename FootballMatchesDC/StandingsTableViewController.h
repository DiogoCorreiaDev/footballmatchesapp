//
//  StandingsTableViewController.h
//  FootballMatchesDC
//
//  Created by user146165 on 9/25/18.
//  Copyright © 2018 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Competition.h"
#import "Match.h"

NS_ASSUME_NONNULL_BEGIN

@interface StandingsTableViewController : UITableViewController

@property (strong, nonatomic) Match *matchSelected;

- (NSString *)description;

@end

NS_ASSUME_NONNULL_END
