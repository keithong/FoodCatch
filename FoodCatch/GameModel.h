//
//  GameModel.h
//  FoodCatch
//
//  Created by Keith Samson on 7/25/14.
//  Copyright (c) 2014 Keith Samson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameModel : NSObject
@property (nonatomic) int playerScore;
@property (nonatomic) int playerLife;
-(id)initWithScore:(int)score life:(int)life;
-(void)setScore:(int)score;
-(void)setLife:(int)life;
@end
