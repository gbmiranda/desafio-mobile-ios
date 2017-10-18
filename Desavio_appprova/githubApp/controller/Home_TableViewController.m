//
//  Home_TableViewController.m
//  githubApp
//
//  Created by Brandao, Camillo on 09/10/17.
//  Copyright © 2017 Brandao, Camillo. All rights reserved.
//

#import "Home_TableViewController.h"
#import "UITableViewController+ENFooterActivityIndicatorView.h"
#import <AFNetworking/UIKit+AFNetworking.h>
#import "DetailTableViewController.h"
#import "home_Model.h"


@interface Home_TableViewController ()
{
    NSData *datafinal;
    home_Model *getData;
    int pageCount;
    BOOL isPageRefreshing;
    UIImageView *avatar;
}
@property (nonatomic, assign) BOOL isLoading;

@end

@implementation Home_TableViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    pageCount = 0;
    [NSThread detachNewThreadSelector:@selector(getRecords) toTarget:self withObject:nil];
    
    
    self.navigationItem.title = @"GitHub JavaPop";
    
    __weak typeof(self) weakSelf = self;
    [self setTableScrolledDownBlock:^void() {
        if (!weakSelf.isLoading)
            [weakSelf loadNextBatch];
    }];
    
}


- (void)loadNextBatch {
    _isLoading = YES;
    if (![self footerActivityIndicatorView])
        [self addFooterActivityIndicatorWithHeight:80.f];
}

-(void)viewWillAppear:(BOOL)animated
{
//    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.mode = MBProgressHUDBackgroundStyleBlur;
//    hud.label.text = NSLocalizedString(@"Carregando...", @"Aguarde...");
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    NSDictionary *dictItems = (NSDictionary *) [_items objectAtIndex:indexPath.row];
   
   
    
    UITextField *nameRep = (UITextField*)[cell viewWithTag:1];
    UITextField *description = (UITextField*)[cell viewWithTag:2];
    UITextField *name = (UITextField*)[cell viewWithTag:3];
    UITextField *fullName = (UITextField*)[cell viewWithTag:4];
    UITextField *forks = (UITextField*)[cell viewWithTag:5];
    UITextField *stars = (UITextField*)[cell viewWithTag:6];
    
   
    
    if ([dictItems objectForKey:@"description"] != (id)[NSNull null])
    {
        description.text = [dictItems objectForKey:@"description"];
    }
    
    if ([dictItems objectForKey:@"full_name"] != (id)[NSNull null])
    {
        nameRep.text = [dictItems objectForKey:@"full_name"];
        fullName.text = [dictItems objectForKey:@"full_name"];
    }
    
    if ([[dictItems objectForKey:@"forks"] stringValue] != (id)[NSNull null])
    {
        forks.text = [[dictItems objectForKey:@"forks"] stringValue];
    }
    
    if ([[dictItems objectForKey:@"stargazers_count"] stringValue] != (id)[NSNull null])
    {
        stars.text = [[dictItems objectForKey:@"stargazers_count"] stringValue];
    }
    
    if ([dictItems objectForKey:@"name"] != (id)[NSNull null])
    {
        name.text = [dictItems objectForKey:@"name"];
    }
    
    
    NSDictionary *itemsAvatar = (NSDictionary *) [dictItems objectForKey:@"owner"];
    avatar = (UIImageView*)[cell viewWithTag:7];

    [avatar setImageWithURL:[NSURL URLWithString:[itemsAvatar valueForKey:@"avatar_url"]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictItems = (NSDictionary *) [_items objectAtIndex:indexPath.row];
    DetailTableViewController *principal = [[self storyboard]instantiateViewControllerWithIdentifier:@"DetailTableViewController"];
    [principal receiveURL:[dictItems objectForKey:@"pulls_url"]];
    [principal receiveName:[dictItems objectForKey:@"name"] :[dictItems objectForKey:@"full_name"]];
    [[self navigationController] pushViewController:principal animated:YES];

}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float offset = (scrollView.contentOffset.y - (scrollView.contentSize.height - scrollView.frame.size.height));
    if (offset >= 0 && offset <= 105)
    {
        isPageRefreshing = NO;
        [self performSelectorInBackground:@selector(updateDataSource) withObject:nil];
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

-(void)updateDataSource
{
    pageCount=pageCount+1;
    if (isPageRefreshing==NO) {
        self.items = [getData nextPage:pageCount];
        [self.tableView reloadData];
        isPageRefreshing=NO;
    }
    
}

-(void)getRecords
{       isPageRefreshing = NO;
        getData = [[home_Model alloc] init];
        self.items = [getData getRecords:pageCount];
        pageCount = pageCount+1;
        [self.tableView reloadData];
    
}


@end
