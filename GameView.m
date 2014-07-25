//
//  GameView.m
//  FoodCatch
//
//  Created by Keith Samson on 7/25/14.
//  Copyright (c) 2014 Keith Samson. All rights reserved.
//

#import "GameView.h"

//int const BASKET_WIDTH = 60;
//int const BASKET_HEIGHT = 20;
//int const BASKET_FLOOR_GAP = 60;
//int const BASKET_MOVE_INTERVAL = 10;
//
//float const BASKET_MINIMUM_PRESS_DURATION = .0000000000001;
//
//// Food Properties
//int const FOOD_SIZE = 15;
//float const FOOD_FALL_ANIMATION_DURATION = .6;
//
//// Floor Property
//int const FLOOR_HEIGHT = 1;
//
//// Timers Properties
//float const FOOD_TIMER_INTERVAL = .6;
//float const FOOD_COLLISION_INTERVAL = .05;
//
//// Labels Properties
//int const SCORE = 0;
//int const LIFE = 3;
//
//int const LABEL_HEIGHT = 80;
//int const LABEL_WIDTH = 90;


@interface GameView ()
@property (retain, nonatomic) NSTimer *foodTimer;
@property (retain, nonatomic) NSTimer *foodFloorCollisionTimer;
@property (retain, nonatomic) NSTimer *foodBasketCollisionTimer;

@property (retain, nonatomic) NSMutableArray *foodArray;

@property (retain, nonatomic) UILongPressGestureRecognizer *basketMover;


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

@end

@implementation GameView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)printSomething
{
    NSLog(@"Hello, World!");
}

- (void)makeFoodFall
{
    NSLog(@"Hi");
    [UIView animateWithDuration:.1 animations:^{
        self.food.frame = CGRectMake(300, 50, 15, 15);
    }];
}

- (void)tapRecognizer
{
    NSLog(@"tap");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc {
    [self.basket release];
    [self.food release];
    [self.floor release];
    [self.lifeLabel release];
    [self.scoreLabel release];

    [super dealloc];
}
@end
