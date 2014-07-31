//
//  JsonViewController.m
//  FoodCatch
//
//  Created by Keith Samson on 7/31/14.
//  Copyright (c) 2014 Keith Samson. All rights reserved.
//

#import "JsonViewController.h"
#import "JsonModel.h"
#import "JsonView.h"

@interface JsonViewController()

@property (retain, nonatomic) NSURLSession *session;
@property (retain, nonatomic) NSMutableDictionary *appDictionary;
@property (retain, nonatomic) NSDictionary *jsonObject;
@property (retain, nonatomic) NSDictionary *feed;

@property (retain, nonatomic) NSMutableArray *fixedEntry;
@property (retain, nonatomic) NSArray *entry;


@property (retain, nonatomic) NSString *appName;
@property (retain, nonatomic) NSString *appArtist;

@end

@implementation JsonViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self){
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:nil delegateQueue:nil];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"JsonView" bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:@"JsonView"];
    [self fetchJson];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO]; 
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.entry count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JsonView *cell = [tableView dequeueReusableCellWithIdentifier:@"JsonView" forIndexPath:indexPath];
    NSLog(@"%@", cell);
    NSDictionary *cellIdentifier = [self.fixedEntry objectAtIndex:indexPath.row];
    
    JsonModel *jsonModel = [[[JsonModel alloc]initWithDictionary:cellIdentifier]autorelease];
//    
//    cell.lblAppName.text = jsonModel.modelAppName;
//    cell.lblAppArtist.text = jsonModel.modelAppArtist;
    
    return cell;
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

            for (int i = 0 ; i < [self.entry count]; i++) {
                self.appDictionary = [NSMutableDictionary dictionary];
                NSDictionary *dict = self.entry[i];
                NSDictionary *imName = dict[@"im:name"];
                NSDictionary *imArtist = dict[@"im:artist"];
                self.appName = imName[@"label"];
                self.appArtist = imArtist[@"label"];
                
                
                [self.appDictionary setValue:self.appName forKey:@"appName"];
                [self.appDictionary setValue:self.appArtist forKey:@"appArtist"];
                [self.fixedEntry addObject:self.appDictionary];
            }
        
        dispatch_async(dispatch_get_main_queue(), ^{[self.tableView reloadData];});
    }];
    [dataTask resume];
}



@end
