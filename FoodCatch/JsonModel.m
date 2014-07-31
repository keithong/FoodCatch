//
//  JsonModel.m
//  FoodCatch
//
//  Created by Keith Samson on 7/31/14.
//  Copyright (c) 2014 Keith Samson. All rights reserved.
//

#import "JsonModel.h"

@implementation JsonModel

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.modelAppName = [dict objectForKey: @"appName"];
        self.modelAppArtist = [dict objectForKey: @"appArtist"];
    }
    return self;
}


@end
