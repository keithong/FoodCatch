//
//  JsonViewController.m
//  FoodCatch
//
//  Created by Keith Samson on 7/31/14.
//  Copyright (c) 2014 Keith Samson. All rights reserved.
//

#import "JsonViewController.h"
#import "JsonModel.h"
#import "JsonCell.h"

@interface JsonViewController()

@property (retain, nonatomic) NSURLSession *session;
@property (retain, nonatomic) NSMutableDictionary *appDictionary;
@property (retain, nonatomic) NSDictionary *jsonObject;
@property (retain, nonatomic) NSDictionary *feed;

@property (retain, nonatomic) NSMutableArray *fixedEntry;
@property (retain, nonatomic) NSArray *entry;

@property (retain, nonatomic) NSString *appName;
@property (retain, nonatomic) NSString *appArtist;

@property (retain, nonatomic) NSString *appNameForCell;
@property (retain, nonatomic) NSString *appArtistForCell;

@end

@implementation JsonViewController

- (id)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if(self){
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:nil delegateQueue:nil];
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self attemptConnect];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Use the fixed entry as your return count
    return [self.fixedEntry count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellName = @"JsonCell";
    
    UINib *nib = [UINib nibWithNibName:cellName bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:cellName];
    
    JsonCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // If the system failed to create the cell, create a new one
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle]loadNibNamed:cellName owner:self options:nil];
        cell = [array objectAtIndex:0];
    }
    
    NSDictionary *cellIdentifier = [self.fixedEntry objectAtIndex:indexPath.row];
    
    JsonModel *jsonModel = [[[JsonModel alloc]initWithDictionary:cellIdentifier]autorelease];
    
    cell.labelAppName.text = jsonModel.modelAppName;
    cell.labelAppArtist.text = jsonModel.modelAppArtist;
    
    return cell;
}

- (void)attemptConnect
{
    // Check the internet connection first
    NSString *requestString = @"https://itunes.apple.com/ph";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestString]];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               
                               if (!connectionError) {
                                   [self fetchJson];
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

- (void)fetchJson
{
    NSString *requestString = @"https://itunes.apple.com/ph/rss/topfreeapplications/limit=50/json";
    NSURL *url = [NSURL URLWithString:requestString];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        self.jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.feed = self.jsonObject[@"feed"];
        self.entry = self.feed[@"entry"];
        
        self.fixedEntry = [NSMutableArray array];
        
        // The JSON array has many dictionary inside it
        // Search the whole JSON array for the app name and app artist
        for (NSDictionary *dict in self.entry){
            self.appDictionary = [NSMutableDictionary dictionary];
            NSDictionary *imName = dict[@"im:name"];
            NSDictionary *imArtist = dict[@"im:artist"];
            self.appName = imName[@"label"];
            self.appArtist = imArtist[@"label"];
            
            // Get only the app name and app artist from the JSON array
            // And assign them to a new array for an easier search in the future
            [self.appDictionary setValue:self.appName forKey:@"appName"];
            [self.appDictionary setValue:self.appArtist forKey:@"appArtist"];
            [self.fixedEntry addObject:self.appDictionary];
        }
        dispatch_async(dispatch_get_main_queue(), ^{[self.tableView reloadData];});
    }];
    [dataTask resume];
}

@end
