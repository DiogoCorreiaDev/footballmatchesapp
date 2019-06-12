//
//  MatchesViewController.m
//  FootballMatchesDC
//
//  Created by Developer on 22/09/18.
//  Copyright © 2018 Developer. All rights reserved.
//

#import "MatchesViewController.h"
#import "MatchesClientAPI.h"
#import "MatchTableViewCell.h"
#import "StandingsTableViewController.h"

@interface MatchesViewController ()

@property (strong, nonatomic) NSMutableArray <Match *> *matches;
@property (weak, nonatomic) IBOutlet UITableView *matchesTableView;
@property (weak, nonatomic) IBOutlet UIButton *tomorrowButton;
@property (weak, nonatomic) IBOutlet UIButton *todayButton;
@property (weak, nonatomic) IBOutlet UIButton *yesterdayButton;


@end

@implementation MatchesViewController

- (void)setMatches:(NSMutableArray<Match *> *)matches
{
    _matches = matches;
    [self updateUI];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    [self getArrayOfCompetitions:self.matches];
    return self.allCompetitions.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    for (int i = 0; i < self.allCompetitions.count ; i++){
        if (i == section) {
            NSLog(@"%@",[self.allCompetitions objectAtIndex:i].competitionName);
            return [self.allCompetitions objectAtIndex:i].competitionName;
            }
    }
    return @"Undetermined Competition";
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.matchesTableView.contentOffset = CGPointMake(0, -self.matchesTableView.refreshControl.frame.size.height);
    [self.matchesTableView.refreshControl beginRefreshing];
    [self updateContentFor:0];
    
}

- (IBAction)refresh:(UIRefreshControl *)sender {
    
    if (sender.isRefreshing) {
        [self updateContentFor:0];
    }
}

- (void)updateContentFor:(NSInteger)dayWhereTodayIsZero{
    
    MatchesClientAPI *clientApi = [MatchesClientAPI new];
    [clientApi getAllMatchesFor:dayWhereTodayIsZero:^(NSArray<Match *> *matches, NSError *error) {
        
        [NSOperationQueue.mainQueue addOperationWithBlock:^{
            
            [self.matchesTableView.refreshControl endRefreshing];
            if (error) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Slight problem :(" message:@"An inconvenience has ocurred with the matches table view..." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
            } else {
                self.matches = [[matches sortedArrayUsingSelector:@selector(compareMatchCompetition:)] copy];
                
            }
        }];
    }];
}- (void)updateUI
{
    [self.matchesTableView reloadData];
}
- (IBAction)updateTomorrowOnButtonClick:(id)sender {
    //[self updateContentForTomorrow];
    [self updateContentFor:1];
    [self updateUI];
}
- (IBAction)updateTodayOnButtonClick:(id)sender {
     //[self updateContent];
    [self updateContentFor:0];
    [self updateUI];
}
- (IBAction)updateYesterdayOnButtonClick:(id)sender {
    [self updateContentFor:-1];
    [self updateUI];
}

#pragma mark - Matches table view data source

- (MatchTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MatchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Match Cell" forIndexPath:indexPath];
    NSArray<NSArray *> *arrayOfArrays = [self getArrayOfArraysOfMatches:self.matches];
    Match *match = arrayOfArrays[indexPath.section][indexPath.row];
        cell.homeTeamNameLabel.text = match.homeTeamName;
        cell.awayTeamNameLabel.text = match.awayTeamName;
        cell.timeLabel.text = match.date;
        cell.statusLabel.text = match.status;
        if ([match.homeTeamScore isKindOfClass:[NSNull class]])
        {
            cell.scoreLabel.text = @"X";
        } else
        {
            cell.scoreLabel.text = [NSString stringWithFormat:@"%@ - %@", match.homeTeamScore, match.awayTeamScore];
        }
        return cell;
        
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray<NSArray *> *arrayOfArrays = [self getArrayOfArraysOfMatches:self.matches];
    for (int i = 0; i < arrayOfArrays.count; i++){
        if (section == i) {
            return [arrayOfArrays objectAtIndex:i].count;
        }
    }
    return arrayOfArrays.count;
}

-(void)getArrayOfCompetitions:(NSArray <Match *>* )matches
{
    NSMutableArray<Competition *> *competitionArray = [NSMutableArray array];
    for (int i = 0; i < matches.count ; i++)
    {
        int counter = 0;
        Competition *competition = [[Competition alloc ]initWithCompetitionID:[matches objectAtIndex:i].competition.competitionId andCompetitionName:[matches objectAtIndex:i].competition.competitionName];
        if (competitionArray.count==0){
            [competitionArray addObject:competition];
        } else {
        for (int j = 0 ; j < competitionArray.count ; j++)
        {
            if ([competitionArray objectAtIndex:j].competitionId==competition.competitionId)
            {
                counter++;
            }
        }
            if (counter == 0) {
                [competitionArray addObject:competition];
            }
        }
    }
    self.allCompetitions = [competitionArray copy];
    NSLog(@"Quantas ligas: %ld",self.allCompetitions.count);
}

-(NSArray *)getArrayOfArraysOfMatches:(NSArray <Match *>* )matches{
    NSMutableArray<NSArray *> *arrayOfArrays = [NSMutableArray array];
    for(int i = 0; i < self.allCompetitions.count; i++){
         NSMutableArray<Match *> *arrayOfMatchesWithEqualCompetition = [NSMutableArray array];
        for (int j = 0; j < matches.count; j++) {
            if ([self.allCompetitions objectAtIndex:i].competitionId==[matches objectAtIndex:j].competition.competitionId) {
                 [arrayOfMatchesWithEqualCompetition addObject:[matches objectAtIndex:j]];
            }
        }
        [arrayOfArrays addObject:arrayOfMatchesWithEqualCompetition];
    }
    //NSLog(@"Array de arrays: %@",arrayOfArrays);
    return arrayOfArrays;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray<NSArray *> *arrayOfArrays = [self getArrayOfArraysOfMatches:self.matches];
    Match *selectedMatch = arrayOfArrays[indexPath.section][indexPath.row];
   // NSLog(@"Match Seleccionado: %@ ", selectedMatch);
    [self performSegueWithIdentifier:@"Show League Standings" sender:selectedMatch];
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Show League Standings"]) {
        StandingsTableViewController *standingsVC = segue.destinationViewController;
        standingsVC.matchSelected = sender;
    }
}

@end
