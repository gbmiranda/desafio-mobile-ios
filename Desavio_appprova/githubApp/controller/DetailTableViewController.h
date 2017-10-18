//
//  DetailTableViewController.h
//  githubApp
//
//  Created by Brandao, Camillo on 17/10/17.
//  Copyright © 2017 Brandao, Camillo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTableViewController : UITableViewController
-(void)receiveURL:(NSString*)urlPull;
- (void)receiveName:(NSString*)name :(NSString*)fullName;
@property NSMutableArray *items;
@end

