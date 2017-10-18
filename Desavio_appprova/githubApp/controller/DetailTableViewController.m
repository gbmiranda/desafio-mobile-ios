//
//  DetailTableViewController.m
//  githubApp
//
//  Created by Brandao, Camillo on 17/10/17.
//  Copyright © 2017 Brandao, Camillo. All rights reserved.
//

#import "DetailTableViewController.h"
#import <AFNetworking/UIKit+AFNetworking.h>
#import "detail_Model.h"
#import "UITableViewController+ENFooterActivityIndicatorView.h"

@interface DetailTableViewController ()
{
    detail_Model *getData;
    UITextField *bodyPull;
    UITextField *titlePull;
    UITextField *nameText;
    UITextField *fullNameText;
    UIImageView *avatar;
    NSString *name;
    NSString *fullName;
}
@property (nonatomic, assign) BOOL isLoading;

@end

@implementation DetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    [self setTableScrolledDownBlock:^void() {
        if (!weakSelf.isLoading)
            [weakSelf loadNextBatch];
    }];
    
     [self loadNextBatch];
    
}

- (void)loadNextBatch {
    _isLoading = YES;
    if (![self footerActivityIndicatorView])
        [self addFooterActivityIndicatorWithHeight:80.f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [_items count];
}

-(void)receiveURL:(NSString*)urlPull
{
    urlPull = [urlPull stringByReplacingOccurrencesOfString:@"{/number}"
                                                   withString:@""];
    
   [NSThread detachNewThreadSelector:@selector(loadingData:) toTarget:self withObject:urlPull];
}

- (void)receiveName:(NSString*)nameReceived :(NSString*)fullNameReceived
{
    name = nameReceived;
    fullName = fullNameReceived;
    
    NSLog(@"Name %@", nameReceived);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *cellIdentifier = @"cellDetail";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    NSDictionary *jsonDict = (NSDictionary *) [self.items objectAtIndex:indexPath.row];
    
   
    bodyPull = (UITextField*)[cell viewWithTag:2];
    
    if ([jsonDict valueForKey:@"body"] != (id)[NSNull null])
    {
        bodyPull.text = [jsonDict valueForKey:@"body"];
    }
    
    fullNameText = (UITextField*)[cell viewWithTag:4];
    fullNameText.text = fullName;
    
    nameText = (UITextField*)[cell viewWithTag:5];
    nameText.text = name;
    
    
    titlePull = (UITextField*)[cell viewWithTag:1];
    titlePull.text = [jsonDict valueForKey:@"title"];
    
    avatar = (UIImageView*)[cell viewWithTag:3];
    
    NSDictionary *dictUser = (NSDictionary *) [jsonDict valueForKey:@"user"];
    
    
   [avatar setImageWithURL:[NSURL URLWithString:[dictUser valueForKey:@"avatar_url"]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
}

-(void)loadingData:(NSString*)urlPull
{
    getData = [[detail_Model alloc] init];
    self.items = [getData getData:urlPull];
    [self.tableView reloadData];
    [self removeFooterActivityIndicator];
    
}

@end
