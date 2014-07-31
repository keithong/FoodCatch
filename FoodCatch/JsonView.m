//
//  JsonView.m
//  FoodCatch
//
//  Created by Keith Samson on 7/31/14.
//  Copyright (c) 2014 Keith Samson. All rights reserved.
//

#import "JsonView.h"

@implementation JsonView

- (void)dealloc {
    [_appNameLabel release];
    [_appArtistLabel release];
    [super dealloc];
}
@end
