//
//  home_Model.h
//  githubApp
//
//  Created by Brandao, Camillo on 18/10/17.
//  Copyright © 2017 Brandao, Camillo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface home_Model : NSObject
@property NSMutableArray *items;
@property NSMutableArray *itemsOwner;
-(NSMutableArray *)nextPage:(int*)page;
-(NSMutableArray *)getRecords:(int*)page;
@end

