//
//  AboutViewController.m
//  FoodCatch
//
//  Created by Keith Samson on 7/17/14.
//  Copyright (c) 2014 Keith Samson. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *aboutWebView;

@end

@implementation AboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self connectToAds];
    [self.navigationController setNavigationBarHidden:NO];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)connectToAds
{
    NSString *requestString = @"http://ads.cyscorpions.com/en/trainingcenter/";
    NSMutableURLRequest *(^requestBlock)(NSString *) = ^(NSString *string)
    {
        NSURL *url = [NSURL URLWithString:requestString];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        return request;
        
    };
    
    [NSURLConnection sendAsynchronousRequest:requestBlock(requestString)
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               
                               if (!connectionError) {
                                   [self.aboutWebView loadRequest:requestBlock(requestString)];
                                   return;
                               }
                               
                               UIAlertView *errorConnecting = [[UIAlertView alloc]
                                                               initWithTitle:@"Error"
                                                               message:@"Failed connect. Please try again."
                                                               delegate:self
                                                               cancelButtonTitle:@"OK"
                                                               otherButtonTitles:nil];
                               [errorConnecting show]; }
     ];
    
}



@end
