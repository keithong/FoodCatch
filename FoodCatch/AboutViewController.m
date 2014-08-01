//
//  AboutViewController.m
//  FoodCatch
//
//  Created by Keith Samson on 7/17/14.
//  Copyright (c) 2014 Keith Samson. All rights reserved.
//

#import "AboutViewController.h"
#import "SVProgressHUD.h"

@interface AboutViewController ()

@property (assign, nonatomic) IBOutlet UIWebView *aboutWebView;

@end

@implementation AboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self connectToAds];
    [self webViewDidStartLoad:self.aboutWebView];
    [self webViewDidFinishLoad:self.aboutWebView];

//    [self showProgressHUD];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)connectToAds
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
                               
                               // Show an error pop-up message if there's no internet connection
                               UIAlertView *errorConnecting = [[UIAlertView alloc]
                                                               initWithTitle:@"Error"
                                                               message:@"Failed connect. Please try again."
                                                               delegate:self
                                                               cancelButtonTitle:@"OK"
                                                               otherButtonTitles:nil];
                               [errorConnecting show];
                               [errorConnecting release];
                               errorConnecting = nil;
                           }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [SVProgressHUD show];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
}

- (void)dealloc
{
    self.aboutWebView = nil;
    [super dealloc];
}

@end
