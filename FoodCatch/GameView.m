//
//  GameView.m
//  FoodCatch
//
//  Created by Keith Samson on 7/25/14.
//  Copyright (c) 2014 Keith Samson. All rights reserved.
//

#import "GameView.h"

// Basket Properties
int const BASKET_WIDTH = 60;
int const BASKET_HEIGHT = 20;
int const BASKET_FLOOR_GAP = 60;
int const BASKET_MOVE_INTERVAL = 10;

// Food Properties
int const FOOD_SIZE = 15;
float const FOOD_FALL_ANIMATION_DURATION = .6;

// Floor Property
int const FLOOR_HEIGHT = 1;

// Label Properties
int const LABEL_HEIGHT = 80;
int const LABEL_WIDTH = 90;

@implementation GameView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        }
    return self;
}

#pragma mark - Game Elements

- (void)gameMeasures
{
    // This method takes the constant values declared above
    // And creates different game measures of the game
    
    self.screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.screenHeight = [UIScreen mainScreen].bounds.size.height;
    self.screenHalf = self.screenWidth/2;
    
    // Defining this for the view controller
    self.basketWidth = BASKET_WIDTH;
    self.basketHeight = BASKET_HEIGHT;
    
    self.basketYPosition = self.screenHeight - (BASKET_HEIGHT + BASKET_FLOOR_GAP);
    
    self.floorWidth = self.screenWidth;
    self.floorYPosition = self.screenHeight - FLOOR_HEIGHT;
    
}

- (void)createBasket
{
    self.basket = [[[UIView alloc]initWithFrame:CGRectMake(self.screenHalf, self.basketYPosition, BASKET_WIDTH, BASKET_HEIGHT)] autorelease];
    self.basket.backgroundColor = [UIColor grayColor];
    self.basketOriginalXPosition = self.basket.frame.origin.x;
}

- (void)createFood
{
    self.foodRandomPosition = arc4random() % self.screenWidth;

    // If the food will be falling outside the left side of the screen, move it inside the screen
    if (self.foodRandomPosition < 0){
        self.foodRandomPosition = FOOD_SIZE;;
    }

    // If the food will be falling outside the right side of the screen, move it inside the screen
    if(self.foodRandomPosition > self.screenWidth - FOOD_SIZE){
        self.foodRandomPosition = self.screenWidth - FOOD_SIZE;
    }

    self.food = [[[UIView alloc] initWithFrame:CGRectMake(self.foodRandomPosition, 0, FOOD_SIZE, FOOD_SIZE)] autorelease];
    self.food.backgroundColor = [UIColor brownColor];

    [self.foodArray addObject:self.food];
    [self makeFoodFall];
    
}

- (void)createFloor
{
    self.floor = [[[UIView alloc] initWithFrame:CGRectMake(0, self.floorYPosition , self.floorWidth, FLOOR_HEIGHT)] autorelease];
}

- (void)createLabels
{
    self.scoreLabel = [[[UILabel alloc]initWithFrame:CGRectMake(LABEL_WIDTH, 0, LABEL_HEIGHT, LABEL_WIDTH)] autorelease];
    self.lifeLabel = [[[UILabel alloc]initWithFrame:CGRectMake(self.screenWidth - LABEL_WIDTH, 0, LABEL_HEIGHT, LABEL_WIDTH)] autorelease];
    
}

#pragma mark - Food Animator

- (void)makeFoodFall
{
    [UIView animateWithDuration:FOOD_FALL_ANIMATION_DURATION animations:^{
        self.food.frame = CGRectMake(self.foodRandomPosition, self.screenHeight, FOOD_SIZE, FOOD_SIZE);
    }];
}

#pragma mark - Collision Checks

- (BOOL)isFoodFloorColliding
{
    return CGRectIntersectsRect([[self.food.layer presentationLayer] frame], [[self.floor.layer presentationLayer] frame]);
}

- (BOOL)isFoodBasketColliding
{
    return CGRectIntersectsRect([[self.food.layer presentationLayer] frame], [[self.basket.layer presentationLayer]frame]);
}

- (void)destroyFood
{
    [self.food removeFromSuperview];
    [self.food.layer removeAllAnimations];
}

- (void)incrementScore:(NSInteger)score
{
    [self.scoreLabel setText:[NSString stringWithFormat:@"Score: %tu", score]];
}

- (void)decrementLife:(NSInteger)life
{
    [self.lifeLabel setText:[NSString stringWithFormat:@"Life: %tu", life]];
}

#pragma mark - Game Over Events

- (void)destroyGameElements
{
    self.foodArray  = nil;

    [self.basket removeFromSuperview];
    [self.food removeFromSuperview];
    [self.floor removeFromSuperview];
    [self.lifeLabel removeFromSuperview];
    [self.scoreLabel removeFromSuperview];
}

- (void)dealloc
{
    [super dealloc];
}
@end
