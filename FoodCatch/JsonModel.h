//
//  JsonModel.h
//  FoodCatch
//
//  Created by Keith Samson on 7/31/14.
//  Copyright (c) 2014 Keith Samson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonModel : NSObject

@property (retain, nonatomic) NSString *modelAppName;
@property (retain, nonatomic) NSString *modelAppArtist;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
