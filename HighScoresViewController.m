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

@interface HighScoresViewController()

@property (retain, nonatomic) NSString *scorePath;
@property (retain, nonatomic) NSString *scoreCellIdentifier;
@property (retain,nonatomic) NSString *playerNameForCell;
@property (retain, nonatomic) NSString *playerScoreForCell;

@property (retain, nonatomic) NSMutableArray *scoreArray;
@property (retain, nonatomic) NSMutableDictionary *cellIdentifier;

-(id)initWithScoreModel:(ScoreModel *)scoreModel;

@end


@implementation HighScoresViewController
-(instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if(self){
    }
    return self;
}

-(instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

-(id)initWithScoreModel:(ScoreModel *)scoreModel
{
    self = [super init];
    self.playerNameForCell = scoreModel.playerName;
    self.playerScoreForCell = scoreModel.playerScore;
    return self;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // I just want to view 10 recent scores.
    if([self.scoreArray count] < 10){
        return [self.scoreArray count];
    }
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScoreCell *cell = [tableView dequeueReusableCellWithIdentifier:self.scoreCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.cellIdentifier = [self.scoreArray objectAtIndex:indexPath.row];
    ScoreModel *score = [[ScoreModel alloc]initWithDictionary:self.cellIdentifier];
    
    HighScoresViewController *highScoreVC = [[HighScoresViewController alloc]initWithScoreModel:score];
    
    cell.playerNameLabel.text = highScoreVC.playerNameForCell;
    cell.playerScoreLabel.text = highScoreVC.playerScoreForCell;
    return cell;
    
    [highScoreVC dealloc];
    [score dealloc];
    
    [highScoreVC release];
    [score release];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Recent Scores";
    
    self.scoreCellIdentifier = [NSString stringWithFormat:@"ScoreCell"];
    
    UINib *nib = [UINib nibWithNibName:self.scoreCellIdentifier bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:self.scoreCellIdentifier];
    
    [self loadScoreList];
}


-(void)loadScoreList
{
    self.scorePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    self.scorePath = [self.scorePath stringByAppendingPathComponent:@"HighScores.plist"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:self.scorePath]) {
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"HighScores" ofType:@"plist"];
        [fileManager copyItemAtPath:sourcePath toPath:self.scorePath error:nil];
    }
    self.scoreArray = [[NSMutableArray alloc] initWithContentsOfFile:self.scorePath];
}

-(void)dealloc
{
    [self.scoreArray dealloc];
    
    [self.scoreArray release];
    [self.scorePath release];
    [self.scoreCellIdentifier release];
    [self.playerNameForCell release];
    [self.playerScoreForCell release];
    [self.scoreArray release];
    [self.cellIdentifier release];
    [super dealloc];
}
@end
