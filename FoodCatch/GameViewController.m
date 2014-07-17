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
@property (retain, nonatomic) UIDynamicAnimator *animator;
@property (retain, nonatomic) UIGravityBehavior *gravity;
@property (retain, nonatomic) UILongPressGestureRecognizer *basketMover;

@property (nonatomic) int screenHeight;
@property (nonatomic) int screenWidth;
@property (nonatomic) float basketOriginalXPosition;
@property (nonatomic) int basketHeight;
@property (nonatomic) int basketWidth;
@property (nonatomic) int foodHeight;
@property (nonatomic) int foodWidth;
@property (nonatomic) int foodRandomPosition;

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
    [self createBasketMover];
    
   
    self.foodTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(createFood) userInfo:nil repeats:YES];
//    [self createFood];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)gameElements
{    self.screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.screenHeight = [UIScreen mainScreen].bounds.size.height;
    self.basketWidth = 60;
    self.basketHeight= 20;
    self.foodWidth = 15;
    self.foodHeight = 15;
    
    self.animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
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
    self.basketOriginalXPosition = self.basket.frame.origin.x;
  
}

- (void)createFood
{
    self.foodRandomPosition = arc4random() % self.screenWidth;
    self.food = [[UIView alloc] initWithFrame:CGRectMake(self.foodRandomPosition, 0, self.foodWidth, self.foodHeight)];
    self.food.backgroundColor = [UIColor brownColor];
    [self.view addSubview:self.food];

    [self makeFoodFall];
}

- (void)makeFoodFall
{
    self.gravity = [[UIGravityBehavior alloc]initWithItems:@[self.food]];
    [self.animator addBehavior:self.gravity];
}

- (void)moveBasket:(UILongPressGestureRecognizer *)gesture
{
    CGPoint screenPoint = [gesture locationInView:self.view];
    
    if(screenPoint.x < self.screenWidth/2) {
        if(self.basketOriginalXPosition != 0){
            self.basket.frame = CGRectMake(self.basketOriginalXPosition -= 5, self.screenHeight - self.basketHeight, self.basketWidth, self.basketHeight);
        }
        return;
    }
    if(self.basketOriginalXPosition != self.screenWidth - self.basketWidth){
        self.basket.frame = CGRectMake(self.basketOriginalXPosition += 5, self.screenHeight - self.basketHeight, self.basketWidth, self.basketHeight);
    }
}

- (void)createBasketMover
{
    self.basketMover = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(moveBasket:)];
    self.basketMover.minimumPressDuration = .1;
    [self.view addGestureRecognizer:self.basketMover];
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
