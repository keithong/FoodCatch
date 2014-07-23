//
//  GameOverViewController.m
//  FoodCatch
//
//  Created by Keith Samson on 7/22/14.
//  Copyright (c) 2014 Keith Samson. All rights reserved.
//

#import "GameOverViewController.h"
#import "GameViewController.h"
#import "ScoreModel.h"

@interface GameOverViewController ()
@property (retain, nonatomic) IBOutlet UIButton *btnMainMenu;
@property (retain, nonatomic) IBOutlet UIButton *btnPlayAgain;

@property (retain, nonatomic) UIAlertView *scoreMessage;
@property (retain, nonatomic) NSString *scorePath;
@property (retain, nonatomic) NSMutableDictionary *newScore;
@property (retain, nonatomic) NSMutableArray *scoreArray;


@end

@implementation GameOverViewController
- (IBAction)goToMainMenu:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:NO];
}
- (IBAction)goToPlay:(id)sender {
    [self.navigationController popToViewController:[self.navigationController viewControllers][1] animated:NO];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadScoreList];
    [self viewScoreMessage];
}

- (void)viewScoreMessage
{
    self.scoreMessage =[[UIAlertView alloc ] initWithTitle:@"Game Over!"
                                                                message:@"Enter your name"
                                                               delegate:self
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles: @"Done", nil];
    self.scoreMessage.alertViewStyle = UIAlertViewStylePlainTextInput;

    [self.scoreMessage show];
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self writeScore];
}

- (void)writeScore
{
    self.newScore = [[NSMutableDictionary alloc]init];
    NSString *scoreToString = [NSString stringWithFormat:@"%d",self.scoreToPass];
    
    [self.newScore setObject:[self.scoreMessage textFieldAtIndex:0].text forKey:@"playerName"];
    [self.newScore setObject:scoreToString forKey:@"playerScore"];
    
    [self.scoreArray addObject:self.newScore];

    [self.scoreArray writeToFile:self.scorePath atomically:YES];
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [self.newScore release];
   
    self.scoreMessage = nil;
    self.newScore = nil;
    self.scoreArray = nil;
    self.btnPlayAgain = nil;
    self.btnMainMenu = nil;
    [super dealloc];
}
@end
