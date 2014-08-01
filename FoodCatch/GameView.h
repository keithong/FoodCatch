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

@property (nonatomic) NSInteger screenHeight;
@property (nonatomic) NSInteger screenWidth;
@property (nonatomic) NSInteger screenHalf;

@property (nonatomic) NSInteger basketHeight;
@property (nonatomic) NSInteger basketWidth;
@property (nonatomic) CGFloat basketOriginalXPosition;
@property (nonatomic) CGFloat basketYPosition;

@property (nonatomic) NSInteger foodRandomPosition;

@property (nonatomic) NSInteger floorWidth;
@property (nonatomic) NSInteger floorYPosition;

@property (nonatomic) NSInteger labelHeight;
@property (nonatomic) NSInteger labelWidth;

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
