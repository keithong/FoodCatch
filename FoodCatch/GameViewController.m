//
//  GameViewController.m
//  FoodCatch
//
//  Created by Keith Samson on 7/17/14.
//  Copyright (c) 2014 Keith Samson. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()
@property (retain, nonatomic) NSTimer *foodTimer;
@property (retain, nonatomic) UIView *basket;
@property (retain, nonatomic) UIView *food;

@property (nonatomic) int screenHeight;
@property (nonatomic) int screenWidth;
@property (nonatomic) int basketHeight;
@property (nonatomic) int basketWidth;
@property (nonatomic) int foodHeight;
@property (nonatomic) int foodWidth;

@end
@implementation GameViewController

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
    [self gameElements];
    [self createBasket];
    [self createFood];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)gameElements
{
    self.screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.screenHeight = [UIScreen mainScreen].bounds.size.height;
    self.basketWidth = 60;
    self.basketHeight= 20;
    self.foodWidth = 15;
    self.foodHeight = 15;
}

- (void)createBasket
{
    self.basket = [[UIView alloc]initWithFrame:
                   CGRectMake(CGRectGetMidX([UIScreen mainScreen].bounds) - self.basketWidth,
                              self.screenHeight-self.basketHeight,
                              self.basketWidth,
                              self.basketHeight)];
    
    self.basket.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:self.basket];
}

- (void)createFood
{
    self.food = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.foodWidth, self.foodHeight)];
    self.food.backgroundColor = [UIColor brownColor];
    
    
    [self.view addSubview:self.food];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
