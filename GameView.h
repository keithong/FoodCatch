//
//  GameView.h
//  FoodCatch
//
//  Created by Keith Samson on 7/25/14.
//  Copyright (c) 2014 Keith Samson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameView : UIView
@property (retain, nonatomic) IBOutlet UIImageView *food;
@property (retain, nonatomic) IBOutlet UILabel *scoreLabel;
@property (retain, nonatomic) IBOutlet UILabel *lifeLabel;
@property (retain, nonatomic) IBOutlet UIImageView *floor;
@property (retain, nonatomic) IBOutlet UIImageView *basket;
-(void)printSomething;
-(void)makeFoodFall;
-(void)tapRecognizer;
@end
