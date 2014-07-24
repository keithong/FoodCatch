//
//  ScoreModel.h
//  FoodCatch
//
//  Created by Keith Samson on 7/22/14.
//  Copyright (c) 2014 Keith Samson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScoreModel : NSObject

@property (retain, nonatomic) NSString *playerName;
@property (retain, nonatomic) NSString *playerScore;
- (id)initWithDictionary:(NSMutableDictionary *)dict;

@end
