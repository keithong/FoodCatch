//
//  GameOverViewController.m
//  FoodCatch
//
//  Created by Keith Samson on 7/22/14.
//  Copyright (c) 2014 Keith Samson. All rights reserved.
//

#import "GameOverViewController.h"
#import "GameViewController.h"

@interface GameOverViewController ()
@property (retain, nonatomic) IBOutlet UIButton *btnMainMenu;
@property (retain, nonatomic) IBOutlet UIButton *btnPlayAgain;

@end

@implementation GameOverViewController
- (IBAction)goToMainMenu:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:NO];
}
- (IBAction)goToPlay:(id)sender {
//    NSArray *viewControllers = [self.navigationController viewControllers];
    [self.navigationController popToViewController:[self.navigationController viewControllers][1] animated:NO];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_btnPlayAgain release];
    [_btnMainMenu release];
    [super dealloc];
}
@end
