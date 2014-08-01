//
//  GameModel.h
//  FoodCatch
//
//  Created by Keith Samson on 7/25/14.
//  Copyright (c) 2014 Keith Samson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameModel : NSObject

@property (nonatomic) NSInteger playerScore;
@property (nonatomic) NSInteger playerLife;

- (id)initWithScore:(NSInteger)score life:(NSInteger)life;
- (void)setScore:(NSInteger)score;
- (void)setLife:(NSInteger)life;

@end
