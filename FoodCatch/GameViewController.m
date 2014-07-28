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
#import "GameModel.h"

float const BASKET_MINIMUM_PRESS_DURATION = .0000000000001;

int const INITIAL_SCORE = 0;
int const INITIAL_LIFE = 3;

// Timers Properties
float const FOOD_TIMER_INTERVAL = .6;
float const FOOD_COLLISION_INTERVAL = .05;

@interface GameViewController ()

@property (retain, nonatomic) UILongPressGestureRecognizer *basketMover;

@property (retain, nonatomic) NSTimer *foodTimer;
@property (retain, nonatomic) NSTimer *foodFloorCollisionTimer;
@property (retain, nonatomic) NSTimer *foodBasketCollisionTimer;

@property (retain, nonatomic) GameView *gameView;
@property (retain, nonatomic) GameModel *gameModel;

@property (nonatomic)int score;
@property (nonatomic)int life;

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
    
    self.gameView = [[[GameView alloc] initWithFrame:self.gameView.frame] autorelease];
    [self.view addSubview:self.gameView];
    
    self.gameModel = [[[GameModel alloc] initWithScore:INITIAL_SCORE life:INITIAL_LIFE] autorelease];
    [self gameElements];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Create Elements

- (void)gameElements
{
    // Call your game elements here
    self.score = INITIAL_SCORE;
    self.life = INITIAL_LIFE;
    
    [self.gameView gameMeasures];
    [self gameTimers];
    [self createFoodInVC];
    [self createBasketInVC];
    
    [self createBasketMover];
    
    [self createFloorInVC];
    [self createLabelsInVC];
}

- (void)createFoodInVC
{
    [self.gameView createFood];
    [self.gameView addSubview:self.gameView.food];
}

- (void)createBasketInVC
{
    [self.gameView createBasket];
    [self.gameView addSubview:self.gameView.basket];
}

- (void)createFloorInVC
{
    [self.gameView createFloor];
    [self.gameView addSubview:self.gameView.floor];
}

- (void)createLabelsInVC
{
    [self.gameView createLabels];
    
    [self.gameView.lifeLabel setText:[NSString stringWithFormat:@"Life: %d", [self getLifeFromModel]]];
    [self.gameView.scoreLabel setText:[NSString stringWithFormat:@"Score: %d", [self getScoreFromModel]]];

    [self.gameView addSubview:self.gameView.scoreLabel];
    [self.gameView addSubview:self.gameView.lifeLabel];
}

- (void)gameTimers
{
    self.foodTimer = [NSTimer   scheduledTimerWithTimeInterval:FOOD_TIMER_INTERVAL
                                                        target:self
                                                      selector:@selector(createFoodInVC)
                                                      userInfo:nil
                                                       repeats:YES];
    
    
    self.foodBasketCollisionTimer = [NSTimer scheduledTimerWithTimeInterval:FOOD_COLLISION_INTERVAL
                                                                     target:self
                                                                   selector:@selector(foodBasketCollision)
                                                                   userInfo:nil
                                                                    repeats:YES];
    
    self.foodFloorCollisionTimer = [NSTimer scheduledTimerWithTimeInterval:FOOD_COLLISION_INTERVAL
                                                                    target:self
                                                                  selector:@selector(foodFloorCollision)
                                                                  userInfo:nil
                                                                   repeats:YES];
}

#pragma mark - Collision Checks

- (void)foodBasketCollision
{
    if([self.gameView isFoodBasketColliding]){
        self.score += 1;
        [self.gameModel setScore:self.score];
        [self.gameView incrementScore:[self getScoreFromModel]];
        [self.gameView destroyFood];
    }
}

- (void)foodFloorCollision
{
    [self gameOver];
    if([self.gameView isFoodFloorColliding]){
        self.life -= 1;
        [self.gameModel setLife:self.life];
        [self.gameView decrementLife:[self getLifeFromModel]];
        [self.gameView destroyFood];
    }
}

- (int)getScoreFromModel
{
    return self.gameModel.playerScore;
}

- (int)getLifeFromModel
{
    return self.gameModel.playerLife;
}

#pragma mark - Basket Mover

- (void)createBasketMover
{
    self.basketMover = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(moveBasket:)];
    self.basketMover.minimumPressDuration = BASKET_MINIMUM_PRESS_DURATION;
    [self.view addGestureRecognizer:self.basketMover];
}

- (void)moveBasket:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateChanged) {
        NSInteger touchCount = [gesture numberOfTouches];
        for (NSInteger t = 0; t < touchCount; t++) {
            CGPoint point = [gesture locationOfTouch:t inView:gesture.view];
            
            // Check if the basket is already at the left or right screen bounds
            if(point.x < self.gameView.screenWidth - self.gameView.basketWidth){
                self.gameView.basket.frame = CGRectMake(point.x, self.gameView.basketYPosition, self.gameView.basketWidth, self.gameView.basketHeight);
                return;
            }
            
        }
    }
}

#pragma mark - Game Over Events

- (void)gameOver
{
    if ([self getLifeFromModel] == 0){
        GameOverViewController *gameOverVC = [[GameOverViewController alloc]init];
        gameOverVC.scoreToPass = self.score;
        [self destroyViewControllerElements];
        [self.navigationController pushViewController:gameOverVC animated:NO];
        [gameOverVC release];
        return;
    }
}

- (void)destroyViewControllerElements
{
    [self.foodTimer invalidate];
    [self.foodBasketCollisionTimer invalidate];
    [self.foodFloorCollisionTimer invalidate];
    
    [self.gameModel setScore:INITIAL_SCORE];
    [self.gameModel setLife:INITIAL_LIFE];
    
    [self.gameView destroyGameElements];
}


- (void)dealloc
{
    [super dealloc];
}

@end
