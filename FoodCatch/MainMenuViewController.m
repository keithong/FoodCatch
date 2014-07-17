//
//  MainMenuViewController.m
//  FoodCatch
//
//  Created by Keith Samson on 7/17/14.
//  Copyright (c) 2014 Keith Samson. All rights reserved.
//

#import "MainMenuViewController.h"
#import "HighScoreViewController.h"
#import "AboutViewController.h"

@interface MainMenuViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnAbout;
@property (weak, nonatomic) IBOutlet UIButton *btnHighScore;
@property (weak, nonatomic) IBOutlet UIButton *btnPlay;

@end

@implementation MainMenuViewController
- (IBAction)goToAbout:(id)sender {
    AboutViewController *aboutVC = [[AboutViewController alloc]init];
    [self.navigationController pushViewController:aboutVC animated:NO];
}
- (IBAction)goToHighScore:(id)sender {
    
    HighScoreViewController *highScoreVC = [[HighScoreViewController alloc]init];
    [self.navigationController pushViewController:highScoreVC animated:NO];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
