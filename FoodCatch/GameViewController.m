//
//  GameViewController.m
//  FoodCatch
//
//  Created by Keith Samson on 7/17/14.
//  Copyright (c) 2014 Keith Samson. All rights reserved.
//
#import "GameViewController.h"
#import "GameOverViewController.h"
#import "GameView.h"

// Basket Properties
int const BASKET_WIDTH = 60;
int const BASKET_HEIGHT = 20;
int const BASKET_FLOOR_GAP = 60;
int const BASKET_MOVE_INTERVAL = 10;

float const BASKET_MINIMUM_PRESS_DURATION = .0000000000001;

// Food Properties
int const FOOD_SIZE = 15;
float const FOOD_FALL_ANIMATION_DURATION = .6;

// Floor Property
int const FLOOR_HEIGHT = 1;

// Timers Properties
float const FOOD_TIMER_INTERVAL = .6;
float const FOOD_COLLISION_INTERVAL = .05;

// Labels Properties
int const SCORE = 0;
int const LIFE = 3;

int const LABEL_HEIGHT = 80;
int const LABEL_WIDTH = 90;

@interface GameViewController ()

@property (retain, nonatomic) NSTimer *foodTimer;
@property (retain, nonatomic) NSTimer *foodFloorCollisionTimer;
@property (retain, nonatomic) NSTimer *foodBasketCollisionTimer;

@property (retain, nonatomic) NSMutableArray *foodArray;

@property (retain, nonatomic) UIView *floor;
@property (retain, nonatomic) UIView *basket;
//@property (retain, nonatomic) UIView *food;

@property (retain, nonatomic) UILongPressGestureRecognizer *basketMover;
@property (retain, nonatomic) UITapGestureRecognizer *tap;

@property (retain, nonatomic) UILabel *scoreLabel;
@property (retain, nonatomic) UILabel *lifeLabel;

@property (nonatomic) int screenHeight;
@property (nonatomic) int screenWidth;
@property (nonatomic) int screenHalf;

@property (nonatomic) int basketHeight;
@property (nonatomic) int basketWidth;
@property (nonatomic) float basketOriginalXPosition;
@property (nonatomic) float basketYPosition;

@property (nonatomic) int foodRandomPosition;

@property (nonatomic) int floorWidth;
@property (nonatomic) int floorYPosition;

@property (nonatomic) int life;
@property (nonatomic) int score;

@property (nonatomic) int labelHeight;
@property (nonatomic) int labelWidth;

@property (retain, nonatomic) GameView *gameView;

@end

@implementation GameViewController

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
    
    self.gameView = [[GameView alloc] init];
    
    [self.view addSubview:self.gameView];
    self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self.gameView action:@selector(tapRecognizer)];
    
    [self.gameView addGestureRecognizer:self.tap];
    [self.gameView makeFoodFall];
    [self.gameView tapRecognizer];
    [self.gameView printSomething];
//    [self gameElements];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)gameElements
{
    // Call your game elements here
//    [self gameMeasures];
    
//    [self createFloor];
//    [self createBasket];
    
    [self createBasketMover];
//    [self createLabels];
}


#pragma mark - Create Elements

- (void)gameMeasures
{
    // This method takes the constant values declared above
    // And creates different game measures of the game
    
    self.screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.screenHeight = [UIScreen mainScreen].bounds.size.height;
    self.screenHalf = self.screenWidth/2;

    self.basketYPosition = self.screenHeight - (BASKET_HEIGHT + BASKET_FLOOR_GAP);
    
    self.floorWidth = self.screenWidth;
    self.floorYPosition = self.screenHeight - FLOOR_HEIGHT;
    
    self.score = SCORE;
    self.life = LIFE;
    
//    self.foodTimer = [NSTimer scheduledTimerWithTimeInterval:FOOD_TIMER_INTERVAL
//                                                      target:self
//                                                    selector:@selector(createFood)
//                                                    userInfo:nil
//                                                     repeats:YES];
    
    self.foodBasketCollisionTimer = [NSTimer scheduledTimerWithTimeInterval:FOOD_COLLISION_INTERVAL
                                                                     target:self
                                                                   selector:@selector(isFoodBasketColliding)
                                                                   userInfo:nil
                                                                    repeats:YES];
    
    self.foodFloorCollisionTimer = [NSTimer scheduledTimerWithTimeInterval:FOOD_COLLISION_INTERVAL
                                                                    target:self
                                                                  selector:@selector(isFoodFloorColliding)
                                                                  userInfo:nil
                                                                   repeats:YES];
}

- (void)createBasket
{
    self.basket = [[[UIView alloc]initWithFrame:CGRectMake(self.screenHalf, self.basketYPosition, BASKET_WIDTH, BASKET_HEIGHT)] autorelease];
    self.basket.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.basket];
    self.basketOriginalXPosition = self.basket.frame.origin.x;
}

//- (void)createFood
//{
//    self.foodRandomPosition = arc4random() % self.screenWidth;
//    
//    // If the food will be falling outside the left side of the screen, move it inside the screen
//    if (self.foodRandomPosition < 0){
//        self.foodRandomPosition = FOOD_SIZE;;
//    }
//    
//    // If the food will be falling outside the right side of the screen, move it inside the screen
//    if(self.foodRandomPosition > self.screenWidth - FOOD_SIZE){
//        self.foodRandomPosition = self.screenWidth - FOOD_SIZE;
//    }
//    
//    self.food = [[[UIView alloc] initWithFrame:CGRectMake(self.foodRandomPosition, 0, FOOD_SIZE, FOOD_SIZE)] autorelease];
//    self.food.backgroundColor = [UIColor brownColor];
//    [self.view addSubview:self.food];
//    
//    [self.foodArray addObject:self.food];
//    [self makeFoodFall];
//}

- (void)createFloor
{
    self.floor = [[[UIView alloc] initWithFrame:CGRectMake(0, self.floorYPosition , self.floorWidth, FLOOR_HEIGHT)] autorelease];
    [self.view addSubview:self.floor];
}

- (void)createLabels
{
    self.scoreLabel = [[[UILabel alloc]initWithFrame:CGRectMake(LABEL_WIDTH, 0, LABEL_HEIGHT, LABEL_WIDTH)] autorelease];
    self.lifeLabel = [[[UILabel alloc]initWithFrame:CGRectMake(self.screenWidth - LABEL_WIDTH, 0, LABEL_HEIGHT, LABEL_WIDTH)] autorelease];
    [self.lifeLabel setText:[NSString stringWithFormat:@"Life: %d", self.life]];
    [self.scoreLabel setText:[NSString stringWithFormat:@"Score: %d", self.score]];
    [self.view addSubview:self.scoreLabel];
    [self.view addSubview:self.lifeLabel];
    
}

#pragma mark - Element Animators

//- (void)makeFoodFall
//{
//    [UIView animateWithDuration:FOOD_FALL_ANIMATION_DURATION animations:^{
//        self.food.frame = CGRectMake(self.foodRandomPosition, self.screenHeight, FOOD_SIZE, FOOD_SIZE);
//    }];
//}

- (void)moveBasket:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateChanged) {
        NSInteger touchCount = [gesture numberOfTouches];
        for (NSInteger t = 0; t < touchCount; t++) {
            CGPoint point = [gesture locationOfTouch:t inView:gesture.view];
            
            // Check if the basket is already at the screen bounds
            if(point.x < self.screenWidth - BASKET_WIDTH){
                self.basket.frame = CGRectMake(point.x, self.basketYPosition, BASKET_WIDTH, BASKET_HEIGHT);
                return;
            }
        
        }
    }
}

- (void)createBasketMover
{
    self.basketMover = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(moveBasket:)];
    self.basketMover.minimumPressDuration = BASKET_MINIMUM_PRESS_DURATION;
    [self.view addGestureRecognizer:self.basketMover];
}

#pragma mark - Collision Checks

//- (void)isFoodBasketColliding
//{
//    // If the presentation layer of the food and the basket collides, the player scores
//    if(CGRectIntersectsRect([[self.food.layer presentationLayer] frame], [[self.basket.layer presentationLayer]frame])){
//        self.score += 1;
//        [self.scoreLabel setText:[NSString stringWithFormat:@"Score: %d", self.score]];
//        
//        [self.food.layer removeAllAnimations];  // Stop the food from falling in the ground
//        [self.food removeFromSuperview];        // Remove the food from the screen
//    }
//}

//- (void)isFoodFloorColliding
//{
//    // Check if life is 0
//    [self gameOver];
//    
//    // If the presentation layer of the food and the floor collides, the player looses a life
//    if(CGRectIntersectsRect([[self.food.layer presentationLayer] frame], [[self.floor.layer presentationLayer] frame])){
//        self.life -=1;
//        [self.lifeLabel setText:[NSString stringWithFormat:@"Life: %d", self.life]];
//        
//        [self.food removeFromSuperview];
//        [self.food.layer removeAllAnimations];
//    }
//}

#pragma mark - Game Over Events

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
//    [self.food removeFromSuperview];
    [self.floor removeFromSuperview];
    [self.lifeLabel removeFromSuperview];
    [self.scoreLabel removeFromSuperview];
    [self.view removeFromSuperview];
    
    self.life = LIFE;
    self.score = SCORE;
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
