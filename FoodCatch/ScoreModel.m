//
//  ScoreModel.m
//  FoodCatch
//
//  Created by Keith Samson on 7/22/14.
//  Copyright (c) 2014 Keith Samson. All rights reserved.
//

#import "ScoreModel.h"

@implementation ScoreModel
-(id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.playerName = [dict objectForKey: @"playerName"];
        self.playerScore = [dict objectForKey: @"playerScore"];
    }
    return self;
}
@end
