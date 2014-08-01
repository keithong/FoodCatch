//
//  GameModel.m
//  FoodCatch
//
//  Created by Keith Samson on 7/25/14.
//  Copyright (c) 2014 Keith Samson. All rights reserved.
//

#import "GameModel.h"

@implementation GameModel

- (id)initWithScore:(NSInteger)score life:(NSInteger)life
{
    self = [super init];
    if (self){
        self.playerScore = score;
        self.playerLife = life;
    }
    return self;
}

- (void)setScore:(NSInteger)score
{
    self.playerScore = score;
}

- (void)setLife:(NSInteger)life
{
    self.playerLife = life;
}

@end
