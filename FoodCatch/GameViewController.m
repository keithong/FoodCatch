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
    
    self.gameView = [[GameView alloc] initWithFrame:self.gameView.frame];
    
    [self.view addSubview:self.gameView];

    [self gameElements];
    self.gameModel = [[GameModel alloc] initWithScore:self.score life:self.life];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Create Elements

- (void)gameElements
{
    // Call your game elements here
    self.score = 0;
    self.life = 3;
    
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
    [self.gameView addSubview:self.gameView.scoreLabel];
    [self.gameView addSubview:self.gameView.lifeLabel];
}

- (void)gameTimers
{
    self.foodTimer = [NSTimer
                      scheduledTimerWithTimeInterval:.6
                      target:self
                      selector:@selector(createFoodInVC)
                      userInfo:nil
                      repeats:YES];
    
    
    self.foodBasketCollisionTimer = [NSTimer scheduledTimerWithTimeInterval:.05
                                                                     target:self
                                                                   selector:@selector(foodBasketCollision)
                                                                   userInfo:nil
                                                                    repeats:YES];
    
    self.foodFloorCollisionTimer = [NSTimer scheduledTimerWithTimeInterval:.05
                                                                    target:self
                                                                  selector:@selector(foodFloorCollision)
                                                                  userInfo:nil
                                                                   repeats:YES];
}

- (void)foodBasketCollision
{
    if([self.gameView isFoodBasketColliding]){
        self.score += 1;
        [self.gameModel setScore:self.score];
        [self.gameView incrementScore:self.gameModel.playerScore];
        [self.gameView destroyFood];
    }
}

- (void)foodFloorCollision
{
    if([self.gameView isFoodFloorColliding]){
        self.life -= 1;
        [self.gameModel setLife:self.life];
        [self.gameView decrementLife:self.gameModel.playerLife];
        
        [self.gameView destroyFood];
    }
}

- (void)createBasketMover
{
    self.basketMover = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(moveBasket:)];
    self.basketMover.minimumPressDuration = .0000001;
    [self.view addGestureRecognizer:self.basketMover];
}

- (void)moveBasket:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateChanged) {
        NSInteger touchCount = [gesture numberOfTouches];
        for (NSInteger t = 0; t < touchCount; t++) {
            CGPoint point = [gesture locationOfTouch:t inView:gesture.view];
            
            // Check if the basket is already at the screen bounds
            if(point.x < self.gameView.screenWidth - 60){
                self.gameView.basket.frame = CGRectMake(point.x, self.gameView.basketYPosition, 60, 20);
                return;
            }
            
        }
    }
}

- (void)gameOver
{
    if (self.life == 0){
        GameOverViewController *gameOverVC = [[GameOverViewController alloc]init];
        gameOverVC.scoreToPass = self.score;
//        [self destroyGameElements];
        [self.navigationController pushViewController:gameOverVC animated:NO];
        [gameOverVC release];
    }
}



- (void)dealloc
{
//    self.basket = nil;
//    self.floor = nil;
//    self.foodArray = nil;
//    self.scoreLabel = nil;
//    self.lifeLabel = nil;
//    self.basketMover = nil;
    
    [super dealloc];
}

@end
