//
//  GameView.h
//  FoodCatch
//
//  Created by Keith Samson on 7/25/14.
//  Copyright (c) 2014 Keith Samson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface GameView : UIView

@property (retain, nonatomic) NSMutableArray *foodArray;
@property (retain, nonatomic) UIView *floor;
@property (retain, nonatomic) UIView *basket;
@property (retain, nonatomic) UIView *food;

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

@property (nonatomic) int labelHeight;
@property (nonatomic) int labelWidth;

- (void)createBasket;
- (void)createFood;
- (void)createFloor;
- (void)createLabels;

- (void)gameMeasures;

- (BOOL)isFoodBasketColliding;
- (BOOL)isFoodFloorColliding;

- (void)decrementLife:(NSInteger)life;
- (void)incrementScore:(NSInteger)score;

- (void)destroyFood;
- (void)destroyGameElements;

@end
