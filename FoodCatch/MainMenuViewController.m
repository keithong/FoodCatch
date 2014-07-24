//
//  MainMenuViewController.m
//  FoodCatch
//
//  Created by Keith Samson on 7/17/14.
//  Copyright (c) 2014 Keith Samson. All rights reserved.
//

#import "MainMenuViewController.h"
#import "AboutViewController.h"
#import "GameViewController.h"
#import "HighScoresViewController.h"

@interface MainMenuViewController ()

@property (assign, nonatomic) IBOutlet UIButton *btnAbout;
@property (assign, nonatomic) IBOutlet UIButton *btnHighScore;
@property (assign, nonatomic) IBOutlet UIButton *btnPlay;

@end

@implementation MainMenuViewController

#pragma mark - Main Menu Button Actions

- (IBAction)goToHighScore:(id)sender {
    HighScoresViewController *highScoreVC = [[HighScoresViewController alloc]init];
    [self.navigationController pushViewController:highScoreVC animated:NO];
    [highScoreVC release];
    highScoreVC = nil;
}

- (IBAction)goToPlay:(id)sender {
    GameViewController *gameVC = [[GameViewController alloc]init];
    [self.navigationController pushViewController:gameVC animated:NO];
    [gameVC release];
    gameVC = nil;
}

- (IBAction)goToAbout:(id)sender {
    AboutViewController *aboutVC = [[AboutViewController alloc]init];
    [self.navigationController pushViewController:aboutVC animated:NO];
    [aboutVC release];
    aboutVC = nil;
}

#pragma mark - General Functions

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
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    self.btnAbout = nil;
    self.btnHighScore = nil;
    self.btnPlay = nil;
    
    [super dealloc];
}

@end
