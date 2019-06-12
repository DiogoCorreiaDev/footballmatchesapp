//
//  StandingsTableViewController.m
//  FootballMatchesDC
//
//  Created by user146165 on 9/25/18.
//  Copyright © 2018 Developer. All rights reserved.
//

#import "StandingsTableViewController.h"
#import "LeaguePosition.h"
#import "MatchesClientAPI.h"
#import "StandingsTableViewCell.h"
#import "FavoriteManager.h"

@interface StandingsTableViewController ()
@property (strong, nonatomic) NSMutableArray <LeaguePosition *> *standings;

@end

@implementation StandingsTableViewController





- (void)addTeamToFavoriteWithTeamName:(NSString *)teamName
{
    if ([teamName isEqualToString:@"Sport Lisboa e Benfica"]) {
         UIAlertController *alertToupeira = [UIAlertController alertControllerWithTitle:@"Toupeira detected" message:@"You cannot add Benfica to favorite. Benfica is terrible." preferredStyle:UIAlertControllerStyleAlert];
         UIAlertAction *sorry = [UIAlertAction actionWithTitle:@"Sorry!" style:UIAlertActionStyleCancel handler:nil];
        [alertToupeira addAction:sorry];
        [self presentViewController:alertToupeira animated:YES completion:nil];
    } else
    {
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Add Favorite" message:@"Are you sure you want to add this team to your favorites?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionYes = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [FavoriteManager createFavoriteTeamWithName:teamName];
    }];
    UIAlertAction *actionNo = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:nil];
     [alert addAction:actionYes];
     [alert addAction:actionNo];
     [self presentViewController:alert animated:YES completion:nil];
    NSString *name = teamName;
    
    [FavoriteManager createFavoriteTeamWithName:name];
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        
    }
}

- (void)setStandings:(NSMutableArray<LeaguePosition *> *)standings
{
    _standings = standings;
    [self updateUI];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tableView.contentOffset = CGPointMake(0, -self.tableView.refreshControl.frame.size.height);
    [self.tableView.refreshControl beginRefreshing];
    [self updateStandingsFor:self.matchSelected.competition];
}

- (IBAction)refresh:(UIRefreshControl *)sender {
    if (sender.isRefreshing) {
        [self updateStandingsFor:self.matchSelected.competition];
    }
}

- (void)updateStandingsFor:(Competition *)competition{
    
    MatchesClientAPI *clientApi = [MatchesClientAPI new];
     [clientApi getStandingsFor:competition:^(NSArray<LeaguePosition *> *standings, NSError *error) {
         
        [NSOperationQueue.mainQueue addOperationWithBlock:^{
            
            [self.tableView.refreshControl endRefreshing];
            if (error) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Slight problem :(" message:@"An inconvenience has ocurred with the standings table view..." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
            } else {
                self.standings = [[standings sortedArrayUsingSelector:@selector(compareLeaguePosition:)] copy];
            }
        }];
    }];
}- (void)updateUI
{
    self.title =[NSString stringWithFormat:@"Standings for: %@", self.matchSelected.competition.competitionName];
    [self.tableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.standings.count;
}

- (StandingsTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StandingsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeaguePosition Cell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];;
    cell.teamNameLabel.textColor = [UIColor blackColor];
    cell.positionLabel.textColor = [UIColor blackColor];
    cell.playedGamesLabel.textColor = [UIColor blackColor];
    cell.pointsLabel.textColor = [UIColor blackColor];
    LeaguePosition *leaguePosition = self.standings[indexPath.row];
    UIImage *img;
    
    if ([FavoriteManager isTeamFavoriteWithTeamName:leaguePosition.teamName]) {
        img = [UIImage imageNamed:@"pintoDaCostaFeliz"];
        cell.favoritesView.image= img;
    } else {
        img = [UIImage imageNamed:@"pintoDaCostaTriste"];
        cell.favoritesView.image= img;
    }
    

    cell.teamNameLabel.text = leaguePosition.teamName;
    cell.positionLabel.text = [NSString stringWithFormat:@"#%@", leaguePosition.position];
    cell.playedGamesLabel.text = [NSString stringWithFormat:@"%@ GP", leaguePosition.playedGames];
    cell.pointsLabel.text = [NSString stringWithFormat:@"%@ PTS", leaguePosition.points];
    if ([leaguePosition.teamName isEqualToString:self.matchSelected.homeTeamName] ||[leaguePosition.teamName isEqualToString:self.matchSelected.awayTeamName]) {
        cell.backgroundColor=[UIColor blueColor];
        cell.teamNameLabel.textColor = [UIColor whiteColor];
        cell.positionLabel.textColor = [UIColor whiteColor];
        cell.playedGamesLabel.textColor = [UIColor whiteColor];
        cell.pointsLabel.textColor = [UIColor whiteColor];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *teamSelectedName = self.standings[indexPath.row].teamName;
    NSLog(@"Equipa Seleccionada: %@ ", teamSelectedName);
    [self addTeamToFavoriteWithTeamName:teamSelectedName];
    
}
- (NSString *)description {
    NSString *descriptionString = [NSString stringWithFormat:@"Standings Table View Controller with total standings %ld", self.standings.count];
    return descriptionString;
    
}
@end
