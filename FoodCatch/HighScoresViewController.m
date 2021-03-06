//
//  HighScoresViewController.m
//  FoodCatch
//
//  Created by Keith Samson on 7/23/14.
//  Copyright (c) 2014 Keith Samson. All rights reserved.
//

#import "HighScoresViewController.h"
#import "ScoreModel.h"
#import "ScoreCell.h"

int const NUM_OF_SCORES = 10;

@interface HighScoresViewController()

@property (retain, nonatomic) NSString *scorePath;
@property (retain, nonatomic) NSString *scoreCellIdentifier;
@property (retain, nonatomic) NSString *playerNameForCell;
@property (retain, nonatomic) NSString *playerScoreForCell;

@property (retain, nonatomic) NSMutableArray *scoreArray;
@property (retain, nonatomic) NSMutableDictionary *cellIdentifier;

@end

@implementation HighScoresViewController

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if(self){
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // We only want to see 10 recent players
    if([self.scoreArray count] < NUM_OF_SCORES){
    return [self.scoreArray count];
    }
    return NUM_OF_SCORES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScoreCell *cell = [tableView dequeueReusableCellWithIdentifier:self.scoreCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // Sort the scores by who played recently
    self.cellIdentifier = [[[self.scoreArray reverseObjectEnumerator] allObjects] objectAtIndex:indexPath.row];    
    ScoreModel *score = [[ScoreModel alloc]initWithDictionary:self.cellIdentifier];
    
    cell.playerNameLabel.text = score.playerName;
    cell.playerScoreLabel.text = score.playerScore;

    [score release];
    return cell;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Recent Scores";
    
    self.scoreCellIdentifier = [NSString stringWithFormat:@"ScoreCell"];
    
    UINib *nib = [UINib nibWithNibName:self.scoreCellIdentifier bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:self.scoreCellIdentifier];
    
    [self loadScoreList];
}

- (void)loadScoreList
{
    self.scorePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    self.scorePath = [self.scorePath stringByAppendingPathComponent:@"HighScores.plist"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:self.scorePath]) {
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"HighScores" ofType:@"plist"];
        [fileManager copyItemAtPath:sourcePath toPath:self.scorePath error:nil];
    }
    self.scoreArray = [[[NSMutableArray alloc] initWithContentsOfFile:self.scorePath] autorelease];

}

- (void)dealloc
{
    [super dealloc];
}
@end
