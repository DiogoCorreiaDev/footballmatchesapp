//
//  MatchTableViewCell.h
//  FootballMatchesDC
//
//  Created by Developer on 22/09/18.
//  Copyright © 2018 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MatchTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *homeTeamNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayTeamNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end
