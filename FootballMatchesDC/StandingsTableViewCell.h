//
//  StandingsTableViewCell.h
//  FootballMatchesDC
//
//  Created by user146165 on 9/25/18.
//  Copyright © 2018 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StandingsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *playedGamesLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *favoritesView;

@end

NS_ASSUME_NONNULL_END
