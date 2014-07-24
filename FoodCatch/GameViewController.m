//
//  GameViewController.m
//  FoodCatch
//
//  Created by Keith Samson on 7/17/14.
//  Copyright (c) 2014 Keith Samson. All rights reserved.
//
#import "GameViewController.h"
#import "GameOverViewController.h"



@interface GameViewController ()
@property (retain, nonatomic) NSTimer *foodTimer;
@property (retain, nonatomic) NSTimer *foodFloorCollisionTimer;
@property (retain, nonatomic) NSTimer *foodBasketCollisionTimer;

@property (retain, nonatomic) NSMutableArray *foodArray;

@property (retain, nonatomic) UIView *floor;
@property (retain, nonatomic) UIView *basket;
@property (retain, nonatomic) UIView *food;

@property (retain, nonatomic) UILongPressGestureRecognizer *basketMover;

@property (retain, nonatomic) UILabel *scoreLabel;
@property (retain, nonatomic) UILabel *lifeLabel;

@property (nonatomic) int screenHeight;
@property (nonatomic) int screenWidth;

@property (nonatomic) float basketOriginalXPosition;
@property (nonatomic) float basketYPosition;
@property (nonatomic) int basketHeight;
@property (nonatomic) int basketWidth;
@property (nonatomic) int basketMoveInterval;
@property (nonatomic) float basketMinimumPressDuration;

@property (nonatomic) int foodHeight;
@property (nonatomic) int foodWidth;
@property (nonatomic) int foodRandomPosition;
@property (nonatomic) float foodFallAnimationDuration;

@property (nonatomic) int floorHeight;
@property (nonatomic) int floorWidth;
@property (nonatomic) int floorYPosition;

@property (nonatomic) int life;
@property (nonatomic) int score;

@property (nonatomic) int labelHeight;
@property (nonatomic) int labelWidth;



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
//    [self gameElements];
   
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self gameElements];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)gameMeasures
{
    // Create a method to store your "magic numbers"
    // And some more game measurements
    
    self.screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    self.basketWidth = 60;
    self.basketHeight= 20;
    self.basketYPosition = self.screenHeight - (self.basketHeight + 5);
    self.basketMoveInterval = 10;
    self.basketMinimumPressDuration = .0000000000001;
    
    self.foodWidth = 15;
    self.foodHeight = 15;
    self.foodFallAnimationDuration = .7;
    
    self.floorHeight = 1;
    self.floorWidth = self.screenWidth;
    self.floorYPosition = self.screenHeight - self.floorHeight;
    
    self.score = 0;
    self.life = 3;
    
    self.foodTimer = [NSTimer scheduledTimerWithTimeInterval:1.2
                                                      target:self
                                                    selector:@selector(createFood)
                                                    userInfo:nil
                                                     repeats:YES];
    
    self.foodBasketCollisionTimer = [NSTimer scheduledTimerWithTimeInterval:.05
                                                                     target:self
                                                                   selector:@selector(isFoodBasketColliding)
                                                                   userInfo:nil
                                                                    repeats:YES];
    
    self.foodFloorCollisionTimer = [NSTimer scheduledTimerWithTimeInterval:.05
                                                                    target:self
                                                                  selector:@selector(isFoodFloorColliding)
                                                                  userInfo:nil
                                                                   repeats:YES];
    
    self.labelHeight = 80;
    self.labelWidth = 90;
    
}

- (void)gameElements
{
    // Call your game elements here
    [self gameMeasures];
    [self createFloor];
    [self createBasket];
    [self createBasketMover];
    [self createLabels];
    [self foodTimer];
    [self foodBasketCollisionTimer];
    [self foodFloorCollisionTimer];
}

- (void)createBasket
{
    self.basket = [[[UIView alloc]initWithFrame:CGRectMake(self.screenWidth/2, self.basketYPosition, self.basketWidth, self.basketHeight)] autorelease];
    self.basket.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.basket];
    self.basketOriginalXPosition = self.basket.frame.origin.x;
}

- (void)createFood
{
    self.foodRandomPosition = arc4random() % self.screenWidth;
    self.food = [[[UIView alloc] initWithFrame:CGRectMake(self.foodRandomPosition, 0, self.foodWidth, self.foodHeight)] autorelease];
    self.food.backgroundColor = [UIColor brownColor];
    [self.view addSubview:self.food];
    
    [self.foodArray addObject:self.food];
    [self makeFoodFall];
}

- (void)createFloor
{
    self.floor = [[[UIView alloc] initWithFrame:CGRectMake(0, self.floorYPosition , self.floorWidth, self.floorHeight)] autorelease];
    [self.view addSubview:self.floor];
}

- (void)createLabels
{
    self.scoreLabel = [[[UILabel alloc]initWithFrame:CGRectMake(self.labelWidth, 0, self.labelHeight, self.labelWidth)] autorelease];
    self.lifeLabel = [[[UILabel alloc]initWithFrame:CGRectMake(self.screenWidth - self.labelWidth, 0, self.labelHeight, self.labelWidth)] autorelease];
    [self.lifeLabel setText:[NSString stringWithFormat:@"Life: %d", self.life]];
    [self.scoreLabel setText:[NSString stringWithFormat:@"Score: %d", self.score]];
    [self.view addSubview:self.scoreLabel];
    [self.view addSubview:self.lifeLabel];
    
}

- (void)makeFoodFall
{
    [UIView animateWithDuration:self.foodFallAnimationDuration animations:^{
        self.food.frame = CGRectMake(self.foodRandomPosition, self.screenHeight, self.foodWidth, self.foodHeight);
    }];
}

- (void)moveBasket:(UILongPressGestureRecognizer *)gesture
{
    CGPoint screenPoint = [gesture locationInView:self.view];
    if(screenPoint.x < self.screenWidth/2) { // If the user taps on the left side of the screen
        if(self.basketOriginalXPosition != 0){ // Check if the basket is already at the left screen bound
            self.basket.frame = CGRectMake(self.basketOriginalXPosition -= self.basketMoveInterval, self.basketYPosition, self.basketWidth, self.basketHeight);
        }
        return;
    }
    
    // The exact opposite of the code above
    if(self.basketOriginalXPosition != self.screenWidth - self.basketWidth){
        self.basket.frame = CGRectMake(self.basketOriginalXPosition += self.basketMoveInterval, self.basketYPosition, self.basketWidth, self.basketHeight);
    }
}

- (void)createBasketMover
{
    self.basketMover = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(moveBasket:)];
    self.basketMover.minimumPressDuration = self.basketMinimumPressDuration;
    [self.view addGestureRecognizer:self.basketMover];
}

- (void)isFoodBasketColliding
{
    // If the presentation layer of the food and the basket collides, the player scores
    if(CGRectIntersectsRect([[self.food.layer presentationLayer] frame], [[self.basket.layer presentationLayer]frame])){
        self.score += 1;
        [self.scoreLabel setText:[NSString stringWithFormat:@"Score: %d", self.score]];
        
        [self.food.layer removeAllAnimations];  // Stop the food from falling in the ground
        [self.food removeFromSuperview];        // Remove the food from the screen
        
    }
}

- (void)isFoodFloorColliding
{
    // Check if life is 0
    [self gameOver];
    
    // If the presentation layer of the food and the floor collides, the player looses a life
    if(CGRectIntersectsRect([[self.food.layer presentationLayer] frame], [[self.floor.layer presentationLayer] frame])){
        self.life -=1;
        [self.lifeLabel setText:[NSString stringWithFormat:@"Life: %d", self.life]];
        
        [self.food removeFromSuperview];
        [self.food.layer removeAllAnimations];
        
    }
}

- (void)gameOver
{
    if (self.life == 0){
        GameOverViewController *gameOverVC = [[GameOverViewController alloc]init];
        gameOverVC.scoreToPass = self.score;
        [self destroyGameElements];
        [self.navigationController pushViewController:gameOverVC animated:NO];
        [gameOverVC release];
    }
}

- (void)destroyGameElements
{
    [self.foodTimer invalidate];
    [self.foodBasketCollisionTimer invalidate];
    [self.foodFloorCollisionTimer invalidate];
    [self.basket removeFromSuperview];
    [self.food removeFromSuperview];
    [self.floor removeFromSuperview];
    [self.lifeLabel removeFromSuperview];
    [self.scoreLabel removeFromSuperview];
    [self.view removeFromSuperview];
    self.life = 3;
    self.score = 0;
    
}

- (void)dealloc
{
    self.basket = nil;
    self.floor = nil;
    self.foodArray = nil;
    self.scoreLabel = nil;
    self.lifeLabel = nil;
    self.basketMover = nil;
    
    [super dealloc];
}


@end
